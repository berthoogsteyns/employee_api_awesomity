use Mix.Config

config :employee_management_api, EmployeeManagementApiWeb.Mailer,
  adapter: Bamboo.MailgunAdapter,
  domain: "https://api.mailgun.net/v3/sandboxa016843074d24f658cf0f24359d31562.mailgun.org",
  api_key: "872fbbb33bbf5358db069431b6e3e0fd-2fbe671d-49ddb4ed"
