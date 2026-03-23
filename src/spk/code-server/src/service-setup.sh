service_prestart() {
	echo "service_prestart: Before service start"

	ln -s ${SYNOPKG_PKGDEST}/etc/alias.code-server.conf /etc/nginx/conf.d/alias.code-server.conf

	if nginx -t >/dev/null 2>&1; then
		systemctl reload nginx
	else
		rm -f /etc/nginx/conf.d/alias.code-server.conf
		echo "nginx configuration error"
	fi

	mkdir -p "${SYNOPKG_PKGVAR}/data"

	nohup ${SYNOPKG_PKGDEST}/lib/code-server/bin/code-server \
		--config ${SYNOPKG_PKGDEST}/etc/code-server.yaml \
		--user-data-dir ${SYNOPKG_PKGVAR}/data \
		--base-path /code-server \
		>${LOG_FILE} 2>&1 &
	echo $! >"${PID_FILE}"
}

service_poststop() {
	echo "service_poststop: After service stop"

	rm -f /etc/nginx/conf.d/alias.code-server.conf
	systemctl reload nginx

	if [ -n "${PID_FILE}" -a -r "${PID_FILE}" ]; then
		for pid in $(cat "${PID_FILE}"); do
			kill -TERM ${pid} >>${LOG_FILE} 2>&1
			wait_for_status 1 ${SVC_WAIT_TIMEOUT:=20} ${pid} || kill -KILL ${pid} >>${LOG_FILE} 2>&1
		done
		if [ -f "${PID_FILE}" ]; then
			rm -f "${PID_FILE}" >/dev/null
		fi
	fi
}
