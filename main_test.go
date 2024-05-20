package main

import (
	"testing"

	"github.com/go-resty/resty/v2"
	"github.com/stretchr/testify/assert"
)

func TestPingEndpoint(t *testing.T) {
	client := resty.New()

	resp, err := client.R().
		Get("http://localhost:9090/ping")

	assert.NoError(t, err)
	assert.Equal(t, 200, resp.StatusCode())
	assert.Contains(t, resp.String(), "pong")
}
