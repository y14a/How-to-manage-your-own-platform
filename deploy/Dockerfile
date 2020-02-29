FROM    python:3.8-alpine AS CONFIG
ARG     SETTING=settings.json

COPY    config/requirements.txt requirements.txt
RUN     apk --update add gcc libc-dev build-base libffi-dev openssl-dev
RUN     pip install -r requirements.txt

COPY    config/ src/

COPY    ${SETTING} src/${SETTING}

RUN     cd src/ &&\
        python genconfig.py -o /assets ${SETTING} 

#######
FROM    cfssl/cfssl:latest  AS SSL

COPY    --from=CONFIG /assets /config

RUN     cd /config/ca &&\
        cfssl gencert -initca ca.csr.json | cfssljson -bare ca &&\
        mkdir -p /assets/ansible/files/ca &&\
        cp *.pem /assets/ansible/files/ca &&\
        for f in $(find /config -type f -name "*.csr.json" -not -name "ca.csr.json" ); \
        do \
            cd $(dirname ${f}) &&\
            suffix=$(echo $(basename ${f}) | sed -e "s/\(.*\)\.csr\.json/\1/") &&\
            host=$(basename $(dirname ${f})) &&\
            cfssl gencert \
                -ca=/assets/ansible/files/ca/ca.pem \
                -ca-key=/assets/ansible/files/ca/ca-key.pem \
                -config=/config/ca/ca.config.json \
                -profile=datacenter ${f} |\
                cfssljson -bare ${suffix} &&\
            mkdir -p /assets/ansible/files/${host} &&\
            cp *.pem /assets/ansible/files/${host} \
        ;\
        done

########
FROM    python:3.8-alpine

RUN     apk --update add gcc libc-dev build-base libffi-dev openssl-dev &&\
        pip install ansible

ENTRYPOINT [ "ansible-playbook" ]

CMD     [ "-i", "inventory", 'site.yml' ]

COPY    ansible /ansible

COPY --from=CONFIG  /assets/inventory.yml /ansible/inventory.yml

COPY --from=SSL     /assets/ansible/files /ansible/files

WORKDIR /ansible