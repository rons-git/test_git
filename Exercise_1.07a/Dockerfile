# Start from the ubuntu image
FROM ubuntu:22.04
# Install curl
RUN apt-get update && apt-get -y install curl
# Copy dockerget.sh to the root docker directory
COPY dockerget.sh .
# Add execution permissions to dockerget.sh during build
RUN chmod +x dockerget.sh
# Assign ENTRYPOINT in docker run to ["./dockerget.sh"]
ENTRYPOINT ["./dockerget.sh"]
