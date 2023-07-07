# Use the official Ruby image as the base image
FROM ruby:2.7.6-slim
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs npm

# Install Yarn
RUN npm install --global yarn

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

# Initialize Yarn and install packages
RUN yarn init -y
RUN yarn add bootstrap@3.3.7 metismenu@3.0.3 jquery@3.3.1 font-awesome@4.6.3 nprogress@0.2.0 malihu-custom-scrollbar-plugin@3.1.3 fastclick@1.0.6

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
