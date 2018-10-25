module Constants
  CURRENCIES = {
    huf: {
      code: 'HUF',
      text: 'Hungarian Forint'
      },
    usd: {
      code: 'USD',
      text: 'US Dollar'
      },
    eur: {
      code: 'EUR',
      text: 'Euro'
      }
  }.freeze

  VALID_MONTHS = (1..12).to_a.freeze
  VALID_YEARS = (18..27).to_a.freeze

  BOOTSTRAP_FLASH_MSG = {
    success: 'alert-success',
    error: 'alert-danger',
    alert: 'alert-warning',
    notice: 'alert-info'
  }.freeze
end
