# Use the official Ruby image as the base image
FROM ruby:2.7.6

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Install Yarn (for Rails asset pipeline)
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y yarn

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install dependencies
RUN bundle install

# Install npm packages (optional, comment this out if not using npm)
RUN yarn install

# Install bootstrap-growl-ifightcrime (add this line to install the package)
RUN yarn add bootstrap-growl-ifightcrime

# Copy the application code into the container
COPY . .

# Expose port 3000 to the host (if your application runs on a different port, change it accordingly)
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
