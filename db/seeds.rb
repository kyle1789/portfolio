Experience.find_or_create_by!(title: "B2B Import & Operations Platform") do |item|
  item.company = "Private B2B platform"
  item.subtitle = "Ruby on Rails · PostgreSQL · Monday.com · GraphQL · Sidekiq · Redis"
  item.short_description = "Professional engineering work on a customer-facing system that turns import, shipment, financial and negotiation workflows into dedicated Rails software."
  item.description = <<~TEXT
    Problem
    Operational information lived across multiple Monday.com boards and business domains. Customers needed a coherent application experience around imports, shipments, negotiations, credits, penalties, discounts, financial indicators and final-value calculations.

    What I worked on
    I integrated Rails with the Monday.com GraphQL API, normalized records from financial, shipment, negotiation and customer boards—including subitems—and mapped them into application concepts. I translated customer-specific rules and operational states into Rails behavior, and customized Devise authentication around normalized Brazilian CNPJ and customer data.

    Engineering highlights
    • Built GraphQL queries and board-specific mappings without exposing private identifiers.
    • Used Sidekiq and Redis for reliable asynchronous processing.
    • Modeled relational business data with PostgreSQL, Active Record and focused service logic.
    • Implemented Rack::Attack throttling for login and broader requests, plus CSP controls.
    • Addressed resource ownership, IDOR-style access risks and customer authorization.
    • Added structured request auditing and traceability of user actions.
  TEXT
  item.technologies = "Ruby, Ruby on Rails, PostgreSQL, Active Record, Monday.com API, GraphQL, Sidekiq, Redis, Devise, Rack::Attack, CSP, Audit logging"
  item.featured = item.current = true
  item.position = 1
end

projects = [
  { name: "StagiLux", short: "Multi-tenant Supplier & Document Management SaaS", tech: "Ruby on Rails, PostgreSQL, acts_as_tenant, Pundit, OCR, ClamAV, Background jobs, Regex", description: <<~TEXT },
    Problem
    Supplier qualification depends on company context, role-aware access, document validity and manual review. The project explores how a B2B SaaS can make that workflow explicit and automatable.

    What I worked on
    I modeled companies, memberships and company-scoped resources with acts_as_tenant. Roles include company admin, employee, supplier, homologation manager and viewer, with active, suspended, inactive and blocked membership states. Pundit policies and scopes keep access tenant- and role-aware.

    Engineering highlights
    • Supplier lifecycle from draft through review and approval.
    • Document states for pending and expired, with scheduled expiration refreshes and notifications.
    • Independent scanning lifecycle: pending scan, clean, infected or failed.
    • Asynchronous ClamAV scanning before documents proceed.
    • OCR text extraction followed by keyword and regex-based content checks to automate part of document verification.
  TEXT
  { name: "CheckoutPay", short: "Payment Processing Architecture", tech: "Ruby on Rails, Sidekiq, Idempotency, Service objects, Transactions", description: <<~TEXT },
    An engineering project focused on reliable transaction-processing concepts rather than a production payment provider.

    It models a payment lifecycle from pending to processing and then succeeded or failed. An idempotency key prevents accidental duplicate charge processing, while a focused charge-creation service and asynchronous processor separate request handling from external processing.
  TEXT
  { name: "OpsFlow", short: "Rails Microservices & Workflow Orchestration Experiment", tech: "Ruby on Rails, JWT, HS256, Sidekiq, Redis, Microservices", description: <<~TEXT },
    An architecture and learning project exploring service communication across auth, intent, planner, process and task services.

    The conceptual flow moves a user from token-based authentication to intent capture, workflow planning, process creation and task orchestration. JWT/HS256 secures service entry points, while Sidekiq and Redis support critical, default and low-priority asynchronous queues.
  TEXT
  { name: "Estoquei", short: "Commerce & Inventory Application", tech: "Ruby on Rails, Active Record, Tailwind CSS, Relational modeling", description: <<~TEXT }
    A Rails application modeling three distinct business actors: customers browse products, manage a cart and checkout; merchants manage products and orders; suppliers use their own dashboard and workflows.

    The project demonstrates Active Record associations, relational modeling and role-oriented application flows in a practical commerce domain.
  TEXT
]

projects.each_with_index do |attributes, index|
  Project.find_or_create_by!(name: attributes[:name]) do |item|
    item.short_description = attributes[:short]
    item.description = attributes[:description]
    item.technologies = attributes[:tech]
    item.featured = index < 2
    item.position = index + 1
  end
end

seed_asset = lambda do |record, filename|
  next if record.screenshots.any? { |attachment| attachment.filename.to_s == filename }

  path = Rails.root.join("db/seed_assets", filename)
  record.screenshots.attach(io: File.open(path, "rb"), filename: filename, content_type: "image/png")
end

professional_work = Experience.find_by!(title: "B2B Import & Operations Platform")
seed_asset.call(professional_work, "from-china-1440x900.png")
seed_asset.call(Project.find_by!(name: "StagiLux"), "stagilux-1440x900.png")
seed_asset.call(Project.find_by!(name: "CheckoutPay"), "checkoutpay-charges.png")
seed_asset.call(Project.find_by!(name: "OpsFlow"), "opsflow-1440x900.png")
seed_asset.call(Project.find_by!(name: "Estoquei"), "estoquei-1440x900.png")
