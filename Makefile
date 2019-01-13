deploy: hugo commit

hugo:
	hugo -t lion

commit:
	./deploy
