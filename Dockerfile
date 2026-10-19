# Railway автоматически собирает по Dockerfile. Зависимостей времени выполнения нет
# (только встроенные модули Node), поэтому build-tools не нужны.
FROM node:20-slim
WORKDIR /app
ENV NODE_ENV=production
COPY package.json package-lock.json* ./
RUN npm install
COPY tsconfig.json ./
COPY src ./src
COPY public ./public
RUN npm run build && npm prune --omit=dev
# Журнал мониторинга лежит в DATA_PATH (по умолчанию data/monitor.json).
# Для сохранения между перезапусками подключите Railway Volume в /app/data.
VOLUME ["/app/data"]
EXPOSE 3000
CMD ["node", "dist/index.js"]
