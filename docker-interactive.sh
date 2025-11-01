#!/bin/bash

# Docker 本地容器交互脚本
# 用于本地开发环境

echo "==================================="
echo "Docker 容器交互选项"
echo "==================================="
echo ""

# 检查是否有运行中的容器
echo "正在查找运行中的容器..."
docker ps

echo ""
echo "选择操作模式:"
echo "1. 进入 app 容器（Django）"
echo "2. 进入 db 容器（PostgreSQL）"
echo "3. 运行 Django 管理命令"
echo "4. 查看容器日志"
echo "5. 启动所有容器"
echo "0. 退出"
echo ""

read -p "请选择 [0-5]: " choice

case $choice in
    1)
        echo "进入 app 容器..."
        docker compose exec app sh
        ;;
    2)
        echo "进入 db 容器..."
        docker compose exec db psql -U devuser -d devdb
        ;;
    3)
        echo "Django 管理命令："
        echo "  a. 运行迁移 (migrate)"
        echo "  b. 创建超级用户 (createsuperuser)"
        echo "  c. Django shell"
        echo "  d. 自定义命令"
        read -p "选择 [a-d]: " subchoice
        
        case $subchoice in
            a)
                docker compose run --rm app sh -c "python manage.py migrate"
                ;;
            b)
                docker compose run --rm app sh -c "python manage.py createsuperuser"
                ;;
            c)
                docker compose run --rm app sh -c "python manage.py shell"
                ;;
            d)
                read -p "输入命令: " cmd
                docker compose run --rm app sh -c "$cmd"
                ;;
        esac
        ;;
    4)
        echo "选择容器日志:"
        echo "  a. app 容器"
        echo "  b. db 容器"
        echo "  c. 所有容器"
        read -p "选择 [a-c]: " logchoice
        
        case $logchoice in
            a)
                docker compose logs -f app
                ;;
            b)
                docker compose logs -f db
                ;;
            c)
                docker compose logs -f
                ;;
        esac
        ;;
    5)
        echo "启动所有容器..."
        docker compose up -d
        ;;
    0)
        echo "退出"
        exit 0
        ;;
    *)
        echo "无效选择"
        ;;
esac
