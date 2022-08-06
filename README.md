# mvsqlite-shell

Minimal Docker container that fires up a SQLite shell on mvsqlite.

## Usage

```
docker build -t mvsqlite-shell .
docker run -it --rm -e MVSQLITE_DATA_PLANE=https://your-data-plane.example.com mvsqlite-shell \
  /run.sh "your-database:some-secret"
```
