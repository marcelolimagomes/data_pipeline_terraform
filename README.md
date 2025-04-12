```markdown
# Ambiente de Desenvolvimento Local Simulando AWS com Terraform

Este projeto configura um ambiente de desenvolvimento local que simula serviços da AWS, incluindo **S3**, **EKS**, **Apache Kafka**, **Apache Airflow**, **PostgreSQL** e **PGVector**, todos rodando em um cluster Kubernetes local. A infraestrutura é provisionada com **Terraform** para garantir versionamento no Git, permitindo reutilização e colaboração.

O ambiente usa **LocalStack** para emular serviços AWS e **Minikube** para simular um cluster Kubernetes (EKS). Este é um ambiente ideal para desenvolvedores que desejam testar aplicações localmente antes de implantá-las na AWS.

## Objetivo

Simular um ambiente AWS completo em uma máquina local com Ubuntu, incluindo:
- **S3**: Armazenamento de objetos.
- **EKS**: Cluster Kubernetes gerenciado.
- **Apache Kafka**: Sistema de mensageria.
- **Apache Airflow**: Orquestração de fluxos de trabalho.
- **PostgreSQL**: Banco de dados relacional.
- **PGVector**: Extensão do PostgreSQL para vetores (usada em aplicações de IA/ML).

## Premissas

- **Sistema Operacional**: Ubuntu 22.04 LTS (ou superior) limpo, sem serviços pré-instalados.
- **Hardware**:
  - Mínimo: 16 GB de RAM, 4 vCPUs, 50 GB de espaço livre em disco.
  - Recomendado: 32 GB de RAM, 8 vCPUs para melhor desempenho.
- **Conexão com a Internet**: Necessária para baixar ferramentas e imagens Docker.
- **Conhecimento Básico**: Familiaridade com linha de comando, Git, Docker, Kubernetes e Terraform.
- **Uso Local**: Este ambiente é projetado para desenvolvimento e testes, não para produção.

## Restrições

- **LocalStack**: Algumas funcionalidades do EKS e outros serviços AWS podem ter suporte limitado no LocalStack.
- **Performance**: Depende dos recursos da máquina local. Clusters pesados (Kafka, Airflow) podem exigir ajustes.
- **Segurança**: Configurações são simplificadas para uso local. Não use em ambientes expostos sem adicionar controles de segurança.
- **PGVector**: Depende da imagem `ankane/pgvector`. Verifique atualizações para garantir compatibilidade.
- **Minikube**: Usado para simular EKS. Algumas funcionalidades avançadas do EKS (como auto-scaling) não estão disponíveis.

## Pré-requisitos

Antes de começar, certifique-se de que sua máquina atende às premissas acima. Você precisará instalar as seguintes ferramentas:

- **Git**: Para versionamento.
- **Terraform**: Para provisionamento da infraestrutura.
- **Docker**: Para contêineres (LocalStack, Minikube).
- **kubectl**: Para gerenciar o cluster Kubernetes.
- **awscli** e **awslocal**: Para interagir com LocalStack.
- **Minikube**: Para simular EKS.
- **Helm**: Para instalar pacotes no Kubernetes.

## Estrutura do Projeto

```plaintext
aws-local-dev/
├── terraform/
│   ├── localstack/
│   │   ├── s3.tf
│   │   └── eks.tf
│   ├── kubernetes/
│   │   ├── kafka.tf
│   │   ├── airflow.tf
│   │   ├── postgres.tf
│   │   └── pgvector.tf
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── .gitignore
└── README.md
```

## Como Executar

Siga os passos abaixo para configurar e executar o ambiente.

### 1. Clonar o Repositório

```bash
git clone <URL_DO_REPOSITORIO>
cd aws-local-dev
```

### 2. Instalar Dependências

Execute os comandos abaixo no Ubuntu para instalar todas as ferramentas necessárias:

```bash
# Atualizar o sistema
sudo apt update && sudo apt upgrade -y

# Instalar ferramentas básicas
sudo apt install -y curl wget unzip git

# Instalar Docker
sudo apt install -y docker.io
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER
# Faça logout e login após este comando

# Instalar Terraform
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt update
sudo apt install -y terraform

# Instalar kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Instalar awscli
sudo apt install -y awscli

# Instalar Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Instalar Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Instalar LocalStack CLI
pip3 install localstack awscli-local
```

### 3. Iniciar Minikube

Inicie o Minikube para criar um cluster Kubernetes local que simula o EKS:

```bash
minikube start --driver=docker --cpus=4 --memory=8192
minikube addons enable ingress
```

### 4. Iniciar LocalStack

Inicie o LocalStack para simular serviços AWS (S3, EKS):

```bash
docker run -d -p 4566:4566 -e SERVICES=s3,eks localstack/localstack
```

### 5. Aplicar Configurações Terraform

Provisione a infraestrutura com Terraform:

```bash
cd terraform
terraform init
terraform apply -auto-approve
```

### 6. Verificar o Ambiente

- **S3**:
  ```bash
  awslocal s3 ls s3://my-local-bucket
  ```

- **Kubernetes**:
  ```bash
  kubectl get pods -A
  ```

- **Airflow**:
  ```bash
  kubectl port-forward svc/airflow-webserver -n airflow 8080:8080
  ```
  Acesse em `http://localhost:8080`.

- **PostgreSQL**:
  ```bash
  kubectl exec -it postgresql-0 -n postgres -- psql -U postgres -d myapp
  ```

- **Kafka**:
  ```bash
  kubectl exec -it kafka-0 -n kafka -- kafka-topics.sh --create --topic test --bootstrap-server localhost:9092
  ```

## Como Contribuir

1. Faça um fork do repositório.
2. Crie uma branch para suas alterações (`git checkout -b minha-contribuicao`).
3. Commit suas mudanças (`git commit -m "Minha contribuição"`).
4. Envie para o repositório remoto (`git push origin minha-contribuicao`).
5. Abra um Pull Request.

## Derrubando o Ambiente

Para limpar o ambiente:

```bash
cd terraform
terraform destroy -auto-approve
minikube delete
docker stop $(docker ps -q)
```

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).

## Contato

Se tiver dúvidas ou sugestões, abra uma issue no repositório ou entre em contato com a comunidade.

---

**Última atualização**: Abril de 2025
```

---

### **Explicação do README**
- **Descrição**: Explica o propósito do projeto e os serviços incluídos.
- **Premissas**: Define claramente o ambiente esperado (Ubuntu, hardware, conhecimento).
- **Restrições**: Alerta sobre limitações (LocalStack, performance, segurança).
- **Instruções**: Passo a passo detalhado para instalar, configurar e testar o ambiente.
- **Estrutura**: Mostra a organização dos arquivos para facilitar navegação.
- **Contribuição**: Orienta como a comunidade pode colaborar.
- **Limpeza**: Inclui instruções para desfazer o ambiente.
- **Licença**: Sugere a licença MIT, mas você pode ajustar conforme necessário.

Esse README é amigável para a comunidade, claro e reutilizável. Se precisar de ajustes ou quiser adicionar algo específico, é só avisar!
