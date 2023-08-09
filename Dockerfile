FROM ubuntu:latest
USER root

# Install dependencies
# aptget update でパッケージリストを更新
RUN apt-get update
# ロケール設定
RUN apt-get -y install locales && localedef -f UTF-8 -i ja_JP ja_JP.UTF-8

# 言語を日本語に設定
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ JST-9
ENV TERM xterm

# pipの環境構築
RUN apt-get install -y python3-pip python3-dev build-essential
RUN pip install --upgrade pip
RUN pip install --upgrade setuptools

# srcディレクトリを作成
RUN mkdir -p /root/src
# requirements.txtをコンテナのsrcディレクトリにコピー
COPY requirements.txt /root/src
# ホストOSのkaggle API キーをコンテナにコピー
COPY ~/Development/DS_env/kaggle.json ~/.kaggle/kaggle.json
# ホストOSのsignate API キーをコンテナにコピー
COPY ~/Development/DS_env/signate.json ~/.signate/signate.json

# 作業ディレクトリをsrcに変更
WORKDIR /root/src

# requirements.txtにリストされたパッケージをインストール
RUN pip install -r requirements.txt