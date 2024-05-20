# Use the official Golang image to create a build artifact.
FROM golang:1.18 AS builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum ./

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download

# Copy the source from the current directory to the Working Directory inside the container
COPY . .

# Build the Go app
RUN go build -o main .

# Install go-test-report
RUN go install github.com/vakenbolt/go-test-report@latest

# Start a new stage from scratch
FROM golang:1.18

WORKDIR /app

# Copy the Pre-built binary file from the previous stage
COPY --from=builder /app/main .
COPY --from=builder /go/bin/go-test-report /usr/local/bin/go-test-report

# Expose port 9090 to the outside world
EXPOSE 9090

# Command to run the executable
CMD ["./main"]
