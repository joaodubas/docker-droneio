# drone.io continuous integration service

This image exposes the [drone.io][droneio] continuous integration service.
Accordingly to it's documentation:

> Drone is a hosted continuous integration service. It enables you to
> conveniently set up projects to automatically build, test, and deploy as you
> make changes to your code.

To get started it's recommended to [read the documentation][droneio-docs] and
[visit their repository][droneio-git].

## Running

Since [drone.io][droneio] needs [docker][docker] to run, it's necessary to
mount docker command line and the docker socket. This way the container will
have access to your `docker-cli` and `docker-daemon`, as [showed by Nathan
Leclaire][docker-tips].

To access the [drone.io][droneio] service, the port _8080_ is exposed, so a
mapping port between host and container can be stablished.

To start a container running [drone.io][droneio]:

```bash
docker run \
    -d \
    --name droneio \
    --hostname droneio 
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /usr/bin/docker:/usr/bin/docker \
    -p 8080:8080 \
    joaodubas/droneio
```

And this will get you a running instance of [drone.io][droneio] o/.

It's important to note that your repositories are cloned to
[`/var/cache/drone/src/github.com/$owner/$name`][droneio-env] directory. So it
would be wise to use a [data volume container][docker-volume-container] to
manage this directory.

Besides the cloned repos, the `sqlite` database used by [drone.io][droneio] is
available in `/var/lib/drone/drone.sqlite`, so another [data volume container]
[docker-volume-container] can be used to share this database with other
services, such as [drone wall][droneio-wall].

[droneio]: http://blog.drone.io
[droneio-docs]: http://docs.drone.io/
[droneio-git]: https://github.com/drone/drone
[droneio-env]: https://github.com/drone/drone#environment
[droneio-wall]: https://github.com/drone/drone-wall
[docker]: https://docker.com/
[docker-volume-container]: https://docs.docker.com/userguide/dockervolumes/#creating-and-mounting-a-data-volume-container
[docker-tips]: http://nathanleclaire.com/blog/2014/07/12/10-docker-tips-and-tricks-that-will-make-you-sing-a-whale-song-of-joy/

## License

> Copyright (c) 2014 Joao Paulo Dubas <joao.dubas@gmail.com>
>
> Permission is hereby granted, free of charge, to any person obtaining a copy
> of this software and associated documentation files (the "Software"), to deal
> in the Software without restriction, including without limitation the rights
> to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> copies of the Software, and to permit persons to whom the Software is
> furnished to do so, subject to the following conditions:
>
> The above copyright notice and this permission notice shall be included in
> all copies or substantial portions of the Software.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> THE SOFTWARE.
