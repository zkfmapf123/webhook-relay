package main

import (
	"context"
	"fmt"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

func handler(ctx context.Context, request events.ALBTargetGroupRequest) (events.ALBTargetGroupResponse, error) {

	parameter := request.QueryStringParameters["Path"]

	fmt.Printf("queryParameter: %+v\n", request.Path)
	fmt.Printf("request: %+v\n", request.Body)

	msg := ""
	switch parameter {
	case "get":
		msg = getingWebhookUrls()

	case "update":
		msg = updateWebhookUrl()

	case "delete":
		msg = deleteWebhookUrl()

	case "webhook":
		msg = comm()
	}

	return events.ALBTargetGroupResponse{
		StatusCode: 200,
		Headers: map[string]string{
			"Content-Type": "application/json",
		},
		Body:            fmt.Sprintf(`{"message": "%s"}`, msg),
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
