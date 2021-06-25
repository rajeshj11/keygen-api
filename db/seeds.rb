# frozen_string_literal: true

EVENT_TYPES = %w[
  account.updated
  account.subscription.paused
  account.subscription.resumed
  account.subscription.canceled
  account.subscription.renewed
  account.plan.updated
  account.billing.updated
  user.created
  user.updated
  user.deleted
  user.password-reset
  product.created
  product.updated
  product.deleted
  policy.created
  policy.updated
  policy.deleted
  policy.pool.popped
  policy.entitlements.attached
  policy.entitlements.detached
  license.created
  license.updated
  license.deleted
  license.expiring-soon
  license.expired
  license.checked-in
  license.check-in-required-soon
  license.check-in-overdue
  license.validated
  license.validation.succeeded
  license.validation.failed
  license.usage.incremented
  license.usage.decremented
  license.usage.reset
  license.renewed
  license.revoked
  license.suspended
  license.reinstated
  license.policy.updated
  license.user.updated
  license.entitlements.attached
  license.entitlements.detached
  machine.created
  machine.updated
  machine.deleted
  machine.heartbeat.ping
  machine.heartbeat.pong
  machine.heartbeat.dead
  machine.heartbeat.reset
  machine.proofs.generated
  key.created
  key.updated
  key.deleted
  token.generated
  token.regenerated
  token.revoked
  entitlement.created
  entitlement.updated
  entitlement.deleted
  release.created
  release.updated
  release.deleted
  release.downloaded
  release.upgraded
  release.uploaded
  release.yanked
  *
].freeze

EVENT_TYPES.each do |event|
  EventType.find_or_create_by!(event: event)
end
