FROM node
# Source dir inside image for app
WORKDIR /user/src/app
COPY package*.json ./
RUN npm install
COPY . .
#ENV vars
ENV NODE_ENV=development
ENV DB_NAME="crawler"
ENV DB_HOST="db"
ENV DB_PORT="5432"
ENV DB_PASSWORD="pg1234"
ENV DB_USERNAME="jack"
ENV JWT_SECRET="9e260443-b62d-452c-aa13-07eb1f3f3fd2"
ENV JWT_EXPIRE_TIME="3"
ENV FRONTEND_URL="http://localhost:8080"
ENV LH_URL="http://localhost:8080"

EXPOSE 3001
# Note this target also starts nodemon 
# which is redundant in a container. 
CMD ["npm", "run", "start:dev"]

