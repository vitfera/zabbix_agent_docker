# Zabbix Agent Docker

Este repositório contém uma configuração Docker Compose para executar o Zabbix Agent 2 em container, permitindo monitoramento de sistemas e containers Docker.

## 📋 Pré-requisitos

- Docker e Docker Compose instalados
- Servidor Zabbix configurado e acessível
- Rede entre o container e o servidor Zabbix

## 🚀 Como usar

1. **Clone este repositório:**
   ```bash
   git clone https://github.com/vitfera/zabbix_agent_docker.git
   ```

2. **Acesse a pasta do projeto:**
   ```bash
   cd zabbix_agent_docker
   ```

3. **Configure as variáveis de ambiente:**
   ```bash
   cp .env.example .env
   nano .env
   ```

4. **Ajuste as configurações no arquivo `.env`:**
   - `ZBX_SERVER_HOST`: IP do seu servidor Zabbix
   - `ZBX_HOSTNAME`: Nome que aparecerá no painel Zabbix
   - Outras variáveis conforme necessário

5. **Execute o container:**
   ```bash
   docker compose up -d
   ```

6. **Verifique se está funcionando:**
   ```bash
   docker compose logs -f
   ```

## ⚙️ Configuração

### Variáveis de Ambiente

| Variável | Descrição | Valor Padrão |
|----------|-----------|--------------|
| `ZBX_SERVER_HOST` | IP do servidor Zabbix | `192.168.1.100` |
| `ZBX_SERVER_PORT` | Porta do servidor Zabbix | `10051` |
| `ZBX_HOSTNAME` | Nome do host no Zabbix | `docker-apps` |
| `ZABBIX_AGENT_PORT` | Porta externa do agente | `10050` |

### Volumes Montados

O container tem acesso aos seguintes diretórios do host para coleta de métricas:

- `/:/hostfs:ro` - Sistema de arquivos completo (somente leitura)
- `/var/run/docker.sock` - Socket do Docker para monitorar containers
- `/etc:/etc:ro` - Configurações do sistema
- `/proc:/host/proc:ro` - Informações de processos
- `/sys:/host/sys:ro` - Informações do sistema
- `/var/run:/var/run` - Runtime do sistema

## 🔧 Comandos Úteis

```bash
# Parar o agente
docker compose down

# Reiniciar o agente
docker compose restart

# Ver logs em tempo real
docker compose logs -f

# Verificar status
docker compose ps
```

## 📊 Sobre o Zabbix Agent

O Zabbix Agent 2 é responsável por:
- Coletar métricas do sistema host
- Monitorar containers Docker
- Enviar dados para o servidor Zabbix
- Permitir execução de comandos remotos (quando configurado)

## 🔒 Segurança

- O arquivo `.env` contém informações sensíveis e está no `.gitignore`
- Use apenas IPs confiáveis para `ZBX_SERVER_HOST`
- Revise as configurações de `ZBX_UNSAFEUSERPARAMETERS` conforme necessário

---

Desenvolvido por [vitfera](https://github.com/vitfera)
