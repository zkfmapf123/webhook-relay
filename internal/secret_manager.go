package internal

import (
	"context"
	"encoding/json"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/secretsmanager"
)

type Config struct {
	SecretManager *secretsmanager.Client
}

func MustSecretManager() Config {
	cfg, err := config.LoadDefaultConfig(context.Background(), config.WithRegion("ap-northeast-2"))
	if err != nil {
		panic(err)
	}

	client := secretsmanager.NewFromConfig(cfg)
	return Config{
		SecretManager: client,
	}
}

func (sm *Config) GetSecret(secretName string) (map[string]string, error) {
	input := &secretsmanager.GetSecretValueInput{
		SecretId: aws.String(secretName),
	}

	result, err := sm.SecretManager.GetSecretValue(context.Background(), input)
	if err != nil {
		return nil, err
	}

	var secretMap map[string]string
	if err := json.Unmarshal([]byte(*result.SecretString), &secretMap); err != nil {
		return nil, err
	}

	return secretMap, nil
}

func (sm *Config) UpdateSecret(secretName, webhookURL, relayURL string) error {

	return nil
}

func (sm *Config) DeleteSecret(secretName string) error {

	return nil
}
