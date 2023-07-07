# frozen_string_literal: true

module Api::V1::ReleasePackages
  class Pypi::SimpleController < Api::V1::BaseController
    include Rendering

    before_action :scope_to_current_account!
    before_action :require_active_subscription!
    before_action :authenticate_with_token
    before_action :set_product

    authorize :product

    def index
      artifacts = authorized_scope(apply_scopes(product.release_artifacts)).limit(1_000)
      authorize! artifacts,
        with: Products::ReleaseArtifactPolicy

      render 'api/v1/packages/pypi/simple/index',
        locals: {
          account: current_account,
          product:,
          artifacts:,
        }
    end

    private

    attr_reader :product

    def set_product
      scoped_products = authorized_scope(current_account.products)

      # TODO(ezekg) Add a distribution_engine attribute to product?
      @product = FindByAliasService.call(
        scoped_products,
        id: params[:id],
        aliases: :code,
      )
    rescue Keygen::Error::NotFoundError
      # Redirect to PyPI when not found to play nicely with PyPI not supporting a per-package index
      # TODO(ezekg) Make this configurable?
      redirect_to "https://pypi.org/simple/#{params[:id]}",
        status: :temporary_redirect,
        allow_other_host: true
    end
  end
end