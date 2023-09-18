FROM mcr.microsoft.com/devcontainers/ruby:1-3.2-bullseye

# Install Rails
RUN gem install rails webdrivers

# Default value to allow debug server to serve content over GitHub Codespace's port forwarding service
# The value is a comma-separated list of allowed domains
ENV RAILS_DEVELOPMENT_HOSTS=".githubpreview.dev,.preview.app.github.dev,.app.github.dev"

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

# [Optional] Uncomment this line to install additional gems.
# RUN gem install <your-gem-names-here>

# [Optional] Uncomment this line to install global node packages.
# RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g <your-package-here>" 2>&1

# #Custom ruby image
# # Use a Ruby base image with your desired Ruby version
# FROM ruby:3.2.2

# # Set the working directory inside the container
# WORKDIR /app

# # Copy your Rails application code into the container
# COPY . .

# # Install dependencies using Bundler
# RUN bundle install

# # Expose the port your Rails app will run on (adjust as needed)
# EXPOSE 3000

# # Command to start your Rails API (adjust as needed)
# CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
