# Install anaconda3 via spack. Using most recent spack version ("develop")
spack-develop:
	docker build -f Dockerfile -t spack-ci-anaconda3 --build-arg SPACK_VERSION=develop  .

# use particular released versions of spack
spack-latest:
	docker build -f Dockerfile --build-arg SPACK_VERSION=releases/latest \
	-t spack-ci-anaconda3 .

spack-v0.18.0:
	docker build -f Dockerfile --build-arg SPACK_VERSION=v0.18.0 \
   -t spack-ci-anaconda3 .

spack-v0.18.1:
	docker build -f Dockerfile --build-arg SPACK_VERSION=v0.18.1 \
   -t spack-ci-anaconda3 .

diff:
	@echo "Compare (diff) spack/package.py with current package.py from spack develop"
	wget --output-document=spack/package-upstream.py https://raw.githubusercontent.com/spack/spack/develop/var/spack/repos/builtin/packages/anaconda3/package.py
	diff spack/package-upstream.py spack/package.py || true

run:
	docker run --rm -ti -v $PWD:/io spack-ci-anaconda3 

.PHONY: spack-v0.18.0 spack-latest spack-develop spack-v0.18.1 diff
