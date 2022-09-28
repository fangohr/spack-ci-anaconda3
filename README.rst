

Testing Anaconda3 package in spack (`spack-ci-anaconda`)
=====================================================

Support repository for packaging of the `ANACONDA3`__ package in
`Spack <http://spack.readthedocs.io>`__.

Status
------

The following targets clone spack, and attempt to install anaconda3 through spack.
The instructions are embedded in `this Dockerfile <Dockerfile>`__.

They following targets all use the default version of anaconda3 (i.e. what spack
would install if we run `spack install anaconda3`).

We try different versions of Spack:

- |spack-develop-anaconda3-stable| Spack develop version (git head), Anaconda3 12.0
- |spack-latest-anaconda3-stable| Spack latest release (=0.18.1), Anaconda3 11.4
- |spack-v0.18.1-anaconda3-stable| Spack release 0.18.1, Anaconda3 11.4
- |spack-v0.18.0-anaconda3-stable| Spack release 0.18.0, Anaconda3 11.4

.. |spack-latest-anaconda3-stable| image:: https://github.com/fangohr/anaconda3-in-spack/actions/workflows/spack-latest.yml/badge.svg
   :target: https://github.com/fangohr/spack-ci-anaconda3/actions/workflows/spack-latest.yml
   
.. |spack-v0.18.0-anaconda3-stable| image:: https://github.com/fangohr/spack-ci-anaconda3/actions/workflows/spack-v0.18.0.yml/badge.svg
   :target: https://github.com/fangohr/spack-ci-anaconda3/actions/workflows/spack-v0.18.0.yml

.. |spack-v0.18.1-anaconda3-stable| image:: https://github.com/fangohr/spack-ci-anaconda3/actions/workflows/spack-v0.18.1.yml/badge.svg
   :target: https://github.com/fangohr/spack-ci-anaconda3/actions/workflows/spack-v0.18.1.yml

.. |spack-develop-anaconda3-stable| image:: https://github.com/fangohr/spack-ci-anaconda3/actions/workflows/spack-develop.yml/badge.svg
   :target: https://github.com/fangohr/spack-ci-anaconda3/actions/workflows/spack-develop.yml
