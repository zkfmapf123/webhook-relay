package main

import (
	"context"
	"fmt"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

func handler(ctx context.Context, request events.ALBTargetGroupRequest) (events.ALBTargetGroupResponse, error) {

	fmt.Printf("queryParameter: %+v\n", request.QueryStringParameters)
	fmt.Printf("request: %+v\n", request.Body)

	return events.ALBTargetGroupResponse{
		StatusCode: 200,
		Headers: map[string]string{
			"Content-Type": "application/json",
		},
		Body:            `{"message": "hello"}`,
		IsBase64Encoded: false,
	}, nil
}

// get
func getingWebhookUrls() {

}

// update
func updateWebhookUrl() {

}

// delete
func deleteWebhookUrl() {

}

// comm
func comm() {

}

func main() {
	lambda.Start(handler)
}
