FROM mcr.microsoft.com/devcontainers/typescript-node:0-18

RUN apt-get update && apt-get install -y \
    git

WORKDIR /

RUN git clone https://github.com/cohenerickson/Velocity.git

WORKDIR /Velocity

RUN npm install && \
    npm run build

# Ensure the server binds to 0.0.0.0
RUN sed -i 's/localhost/0.0.0.0/' scripts/server.js

ENTRYPOINT npm start

# Expose the ports the application listens on
EXPOSE 3000
EXPOSE 8080

# HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD curl -f http://localhost:3000/health || exit 1