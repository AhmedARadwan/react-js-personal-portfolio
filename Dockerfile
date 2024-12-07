# Step 1: Use a Node.js base image to build the app
FROM node:16 AS build

# Set working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the app files
COPY . .

# Build the React app
RUN npm run build

# Step 2: Use a lightweight web server to serve the static files
FROM nginx:stable-alpine

# Copy the build output to the Nginx static directory
COPY --from=build /app/build /usr/share/nginx/html

# Expose the port that Nginx runs on
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
