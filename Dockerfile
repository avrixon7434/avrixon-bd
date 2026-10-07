FROM node:20-bookworm-slim
WORKDIR /app
COPY package*.json ./
RUN npm install --omit=dev --no-audit --no-fund
COPY . .
RUN mkdir -p /var/lib/avrixon && chown -R node:node /app /var/lib/avrixon
USER node
ENV NODE_ENV=production
ENV DB_PATH=/var/lib/avrixon/avrixon.db
EXPOSE 3000
HEALTHCHECK --interval=30s --timeout=5s --start-period=20s --retries=3 CMD node -e "fetch('http://127.0.0.1:3000/api/health').then(r=>process.exit(r.ok?0:1)).catch(()=>process.exit(1))"
CMD ["npm","start"]
