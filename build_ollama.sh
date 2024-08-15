git clone https://github.com/ollama/ollama
cd ollama
go mod vendor
#env GIN_MODE=release OLLAMA_SKIP_CPU_GENERATE=1 go generate ./...; go build
env GIN_MODE=release go generate ./...; go build
