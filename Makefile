# On Windows try https://frippery.org/busybox/

-include config.mk

pkgver!=node -e 'console.log(JSON.parse(fs.readFileSync("package.json")).version)'

version?=v${pkgver}
suffix?=
registry?=ghcr.io/amrc-factoryplus
repo?=acs-admin

docker?=  docker
kubectl?= kubectl

tag=${registry}/${repo}:${version}${suffix}
build_args=

ifdef acs_build
build_args+=--build-arg acs_build="${acs_build}"
endif

ifdef acs_run
build_args+=--build-arg acs_run="${acs_run}"
endif

ifdef acs_npm
build_args+=--build-arg acs_npm="${acs_npm}"
endif


all: build push

.PHONY: all build push check-committed amend

check-committed:
	[ -z "$$(git status --porcelain)" ] || (git status; exit 1)

amend:
	git commit -a -C HEAD --amend

build: check-committed
	${docker} build -t "${tag}" ${build_args} .

push:
	${docker} push "${tag}"

run:
	${docker} run -ti --rm "${tag}" /bin/sh

.PHONY: deploy restart logs

ifdef deployment

deploy: all restart logs

restart:
	${kubectl} rollout restart deploy/"${deployment}"
	${kubectl} rollout status deploy/"${deployment}"
	sleep 2

logs:
	${kubectl} logs -f deploy/"${deployment}" -c frontend

else

deploy restart logs:
	: Set $${deployment} for automatic k8s deployment

endif
