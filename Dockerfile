# Use the official Ruby image as the base image
FROM ruby:2.7.6-slim
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Set the working directory in the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile Gemfile.lock ./

# Install dependencies
RUN bundle install

# Copy the application code into the container
COPY . .

# Expose port 3000 to the host
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
