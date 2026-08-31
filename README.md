# Kyle Teixeira Trindade — Portfolio

A deliberately simple Rails portfolio for presenting professional B2B, SaaS and backend engineering work.

## Local setup

Requirements: Ruby 3.2+, SQLite, and libvips or ImageMagick for screenshot variants.

```bash
bundle install
bin/rails db:prepare db:seed
bin/dev
```

The public portfolio is at `/`; basic content management is at `/admin`. Development keeps the admin open for convenience. In production, `/admin` is protected with HTTP Basic authentication configured through `ADMIN_USERNAME` and `ADMIN_PASSWORD`.

## Configuration

The site defaults to Kyle's current GitHub, LinkedIn, email, phone and the PDF stored at `public/kyle-teixeira-trindade-resume.pdf`. They can be overridden with `PORTFOLIO_GITHUB_URL`, `PORTFOLIO_LINKEDIN_URL`, `PORTFOLIO_RESUME_URL`, `PORTFOLIO_EMAIL`, and `PORTFOLIO_PHONE`.

Screenshots use Active Storage's local disk service. On Fly, the SQLite databases and uploads are persisted by the volume configured in `fly.toml`.

## Deployment

The repository includes a production Dockerfile and a `fly.toml` configured for one small Fly Machine in São Paulo, auto-stop/auto-start, and a 1 GB persistent volume. The volume stores all SQLite databases and Active Storage uploads under `/rails/storage`.

Before the first deploy, confirm that `kyle-trindade-portfolio` is available or change `app` in `fly.toml`, then run:

```bash
fly auth login
fly apps create kyle-trindade-portfolio
fly volumes create portfolio_data --region gru --size 1
fly secrets set SECRET_KEY_BASE="$(bin/rails secret)"
fly secrets set ADMIN_USERNAME=kyle ADMIN_PASSWORD='choose-a-long-unique-password'
fly deploy
```

`SEED_ON_BOOT=true` runs the idempotent seeds after database preparation, ensuring the case studies and screenshots exist on a fresh volume. The Machine can stop when idle, but the persistent volume continues to incur its small storage charge.

For a custom domain, add it through Fly and set the canonical host:

```bash
fly secrets set APP_HOST=portfolio.example.com
```

Replace the example admin password before running the command. Never commit passwords, `.env` files, Fly access tokens, payment information, or `config/master.key` if one is created later.
