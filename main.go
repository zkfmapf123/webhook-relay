package main

import (
	"context"
	"fmt"
	"os"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	"github.com/zkfmapf123/webhook-relay/internal"
)

var (
	SECRET_NAME = os.Getenv("SECRET_NAME")
)

var (
	sm = internal.MustSecretManager()
)

func handler(ctx context.Context, request events.ALBTargetGroupRequest) (events.ALBTargetGroupResponse, error) {

	parameter := request.QueryStringParameters["Path"]

	fmt.Printf("queryParameter: %+v\n", request.Path)
	fmt.Printf("request: %+v\n", request.Body)

	result := ""
	switch parameter {
	case "get":
		result = getingWebhookUrls()

	case "update":
		result = updateWebhookUrl()

	case "delete":
		result = deleteWebhookUrl()

	case "webhook":
		result = comm()
	}

	return events.ALBTargetGroupResponse{
		StatusCode: 200,
		Headers: map[string]string{
			"Content-Type": "application/json",
		},
		Body:            result,
		IsBase64Encoded: false,
	}, nil
}

// get
func getingWebhookUrls() string {

	return "ok"
}

// update
func updateWebhookUrl() string {

	return "ok"
}

// delete
func deleteWebhookUrl() string {

	return "ok"
}

// comm
func comm() string {

	return "ok"
}

func main() {
	lambda.Start(handler)
}
