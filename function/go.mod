module example.com/aws-matsushita-lambda

go 1.20

require (
	github.com/aws/aws-lambda-go v1.43.0
	github.com/aws/aws-sdk-go v1.49.12
)

require github.com/jmespath/go-jmespath v0.4.0 // indirect; indirect　（indirect は「自分が明示的に書いたんじゃないよ」という印。）
