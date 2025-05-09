# -------------------------------
# Stage 1: Build
# -------------------------------
  FROM node:20-alpine AS builder

  # Set working directory inside the container
  WORKDIR /app
  
  # Copy only package.json and package-lock.json (or yarn.lock) first
  # This allows Docker to cache install steps unless these files change
  COPY package*.json ./
  
  # Install all dependencies including devDependencies
  RUN npm install
  
  # Copy the entire project (including TypeScript source files)
  COPY . .
  
  # Compile TypeScript into JavaScript
  RUN npm run build
  
  # -------------------------------
  # Stage 2: Production
  # -------------------------------
  FROM node:20-alpine AS runner
  
  WORKDIR /app
  
  # Only copy package.json to install production dependencies
  COPY package*.json ./
  
  # Install only production dependencies
  RUN npm install --omit=dev
  
  # Copy compiled JavaScript files and other necessary assets from the build stage
  COPY --from=builder /app/dist ./dist
  
  # Expose port (match the one your Express app uses, commonly 3000)
  EXPOSE 3000
  
  # Start the app
  CMD ["node", "dist/app.js"]
  