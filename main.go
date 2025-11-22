package main

import (
	"context"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

func handler(ctx context.Context, request events.ALBTargetGroupRequest) (events.ALBTargetGroupResponse, error) {
	return events.ALBTargetGroupResponse{
		StatusCode: 200,
		Headers: map[string]string{
			"Content-Type": "application/json",
		},
		Body:            `{"message": "hello"}`,
		IsBase64Encoded: false,
	}, nil
}

func main() {
	lambda.Start(handler)
}
