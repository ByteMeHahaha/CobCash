FROM ubuntu:24.04 AS build

RUN apt-get update && \
  apt-get install -y gnucobol && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /src

COPY ./src .

RUN cobc -x main.cbl -I ./copy -o CobCash

# -------------------------------

FROM ubuntu:24.04

RUN apt-get update && \
  apt-get install -y libcob4 && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --from=build /src/CobCash .

CMD ["./CobCash"]
