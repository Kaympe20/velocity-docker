FROM mcr.microsoft.com/devcontainers/typescript-node:0-18

RUN apt-get update && apt-get install -y \
    git

WORKDIR /

RUN git clone https://github.com/cohenerickson/Velocity.git

WORKDIR /Velocity

RUN npm install \
    npm run build

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD curl -f http://localhost:3000/health || exit 1

ENTRYPOINT npm start

EXPOSE 3000
EXPOSE 8080