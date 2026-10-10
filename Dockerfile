# Use Debian as the base image
FROM debian:bookworm-slim AS build

# Install GnuCOBOL
RUN apt-get update && \
  apt-get install -y --no-install-recommends \
    gnucobol && \
  rm -rf /var/lib/apt/lists/*

# Change the working directory to /src
WORKDIR /src

# Copy the source code files into the working directory
COPY ./src .

# Compile the app
RUN cobc -x main.cbl -I ./copy -o CobCash

# -------------------------------

# Use Debian as the base image
FROM debian:bookworm-slim

# Install libcob, a dependency to run GnuCOBOL apps
RUN apt-get update && \
  apt-get install -y --no-install-recommends libcob4 && \
  rm -rf /var/lib/apt/lists/*

# Change the working directory to /app
WORKDIR /app

# Copy the executable into /app
COPY --from=build /src/CobCash .

# Run the executable when the image runs
CMD ["./CobCash"]
