
install:
	mkdir -p "${DESTDIR}"/usr/bin/
	install bin/environ "${DESTDIR}"/usr/bin/
	install -d -m 0755 "${DESTDIR}"/etc/environ.d/
	cd product && for d in * ; do \
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

