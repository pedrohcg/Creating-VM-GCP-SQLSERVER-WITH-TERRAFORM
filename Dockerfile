FROM ubuntu:latest

#autaliza e faz download dos pacotes
RUN apt-get update && \
    apt-get install -y wget unzip curl openssh-client iputils-ping gnupg && \
    apt install sudo

ENV TERRAFORM_VERSION=1.6.4

#baixa terraform, descompacta e move para a pasta bin do container
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

#cria a pasta e mapeia ela como volume
RUN mkdir /lab3
VOLUME /lab3

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg && apt-get update -y && apt-get install google-cloud-sdk -y
       
CMD ["/bin/bash"]