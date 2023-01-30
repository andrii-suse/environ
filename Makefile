
install:
	mkdir -p "${DESTDIR}"/usr/bin/
	mkdir -p "${DESTDIR}"/var/opt/environ
	chmod 777 "${DESTDIR}"/var/opt/environ
	install bin/environ "${DESTDIR}"/usr/bin/
	install -d -m 0755 "${DESTDIR}"/etc/environ.d/
	cd environ.d && for d in * ; do \
		mkdir -p "${DESTDIR}"/etc/environ.d/$$d ;\
		for f in $$d/*.{m4,cnf} ; do \
			test -f $$f && install -m 0644 $$f "${DESTDIR}"/etc/environ.d/$$f ;\
		done ;\
		for dd in $$d/* ; do \
			test -d $$dd || continue ;\
			for f in $$dd/*.m4 ; do \
				test -f $$f || continue ;\
				mkdir -p "${DESTDIR}"/etc/environ.d/$$dd ;\
				install -m 0644 $$f "${DESTDIR}"/etc/environ.d/$$f ;\
			done \
		done \
	done

test:
	for f in environ.d/*/t/*.sh ; do bash -x $f && continue; echo FAIL: $f; break; done

test_leap:
	for f in environ.d/ap/*/*.sh; do echo starting $f; ENVIRON_TEST_IMAGE=registry.opensuse.org/opensuse/leap $f && continue; echo FAIL $f; break; done

test_tw:
	for f in environ.d/ap/*/*.sh; do echo starting $f; ENVIRON_TEST_IMAGE=registry.opensuse.org/opensuse/tumbleweed $f && continue; echo FAIL $f; break; done
