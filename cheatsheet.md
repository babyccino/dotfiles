## find

find all the .csproj files in a dir and execute dotnet restore on them

```bash
find . -name '*.csproj' -exec echo {} \; -exec dotnet restore {} --force-evaluate \;
```

## jq

show all the trace ids of requests with a method of POST

```bash
pbpaste | jq 'select(.RequestMethod == "POST") .TraceId'
```

count occurrences of each Status Code

```bash
jq -r '.StatusCode' logs.json | sort | uniq -c
```

Filter for any requests where the `Elapsed` time was greater than 100ms:

```bash
jq 'select(.Elapsed > 100)' logs.json
```

If you want to scan the logs quickly without seeing the full JSON blob, you can format a custom string:

```bash
jq -r '"\(.["@t"]) | \(.RequestMethod) \(.RequestPath) | \(.StatusCode) (\(.Elapsed)ms)"' logs.json
```

_Note: We use `.["@t"]` because properties starting with `@` must be quoted in jq._

Useful for identifying high-traffic endpoints:

```bash
jq -r '.RequestPath' logs.json | sort | uniq -c | sort -rn | head -n 10
```

Filter for any request that resulted in a 500 Internal Server Error:

```bash
jq 'select(.StatusCode >= 500)' logs.json
```

To calculate the total time spent processing all requests in the log file:

```bash
jq -s 'map(select(.RequestPath != "/")) | map(.Elapsed) | add / length' logs.json
```

This is a more advanced command that shows you which endpoints are the slowest on average:

```bash
jq -s 'group_by(.RequestPath)[] | {path: .[0].RequestPath, avg_time: (map(.Elapsed) | add / length)}' logs.json
```

If you want to narrow down logs between 09:17:30 and 09:17:40:

```bash
jq 'select(.["@t"] >= "2026-03-18T09:17:30" and .["@t"] <= "2026-03-18T09:17:40")' logs.json
```
