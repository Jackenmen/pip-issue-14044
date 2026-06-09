# docker build --progress=plain .
FROM python:3.10

RUN mkdir /tmp/repro

ENV PIP_CACHE_DIR=/tmp/repro/cache

RUN python3.10 -m venv /tmp/repro/.venv
RUN /tmp/repro/.venv/bin/pip install -U 'pip==26.1.2'

RUN mkdir -p /tmp/repro/cache/wheels/9e/32/41/213c095f1dfa427bb3df41ef8612b9c7e3d980c3a5f95d27a8/
RUN wget -O /tmp/repro/cache/wheels/9e/32/41/213c095f1dfa427bb3df41ef8612b9c7e3d980c3a5f95d27a8/red_discordbot-3.5.24-py3-none-any.whl https://github.com/Jackenmen/pip-issue-14044/releases/download/repro/red_discordbot-3.5.24-py3-none-any.whl

RUN mkdir -p /home/ubuntu/work/Red-Install-Tests/deps/repos/Red-DiscordBot
RUN wget -O- https://github.com/Jackenmen/Red-DiscordBot/tarball/refs/heads/fix_argument_handling_in_prompt_builder | tar --strip-components=1 -C /home/ubuntu/work/Red-Install-Tests/deps/repos/Red-DiscordBot -xzvf -

RUN pip install --no-deps 'Red-DiscordBot @ file:///home/ubuntu/work/Red-Install-Tests/deps/repos/Red-DiscordBot'

ENTRYPOINT ["bash"]
