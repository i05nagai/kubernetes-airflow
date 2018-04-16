## Overview

## Usage



```Dockerfile
FROM embulk

COPY Gemfile ${PATH_TO_EMBULK}/Gemfile
RUN ${PATH_TO_EMBULK}/embulk bundle install
```
