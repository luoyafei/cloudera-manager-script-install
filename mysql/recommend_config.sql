CREATE DATABASE IF NOT EXISTS scm DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS amon DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS rman DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;

CREATE DATABASE IF NOT EXISTS hue DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS metastore DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS sentry DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS nav DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE DATABASE IF NOT EXISTS navms DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
-- CREATE DATABASE IF NOT EXISTS oozie DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;

GRANT ALL ON scm.* TO scm@'%' IDENTIFIED BY 'scm';
GRANT ALL ON scm.* TO scm@'localhost' IDENTIFIED BY 'scm';

GRANT ALL ON amon.* TO amon@'%' IDENTIFIED BY 'amon';
GRANT ALL ON amon.* TO amon@'localhost' IDENTIFIED BY 'amon';

GRANT ALL ON rman.* TO rman@'%' IDENTIFIED BY 'rman';
GRANT ALL ON rman.* TO rman@'localhost' IDENTIFIED BY 'rman';

GRANT ALL ON hue.* TO hue@'%' IDENTIFIED BY 'hue';
GRANT ALL ON hue.* TO hue@'localhost' IDENTIFIED BY 'hue';

GRANT ALL ON metastore.* TO metastore@'%' IDENTIFIED BY 'metastore';
GRANT ALL ON metastore.* TO metastore@'localhost' IDENTIFIED BY 'metastore';

GRANT ALL ON sentry.* TO sentry@'%' IDENTIFIED BY 'sentry';
GRANT ALL ON sentry.* TO sentry@'localhost' IDENTIFIED BY 'sentry';

GRANT ALL ON nav.* TO nav@'%' IDENTIFIED BY 'nav';
GRANT ALL ON nav.* TO nav@'localhost' IDENTIFIED BY 'nav';

GRANT ALL ON navms.* TO navms@'%' IDENTIFIED BY 'navms';
GRANT ALL ON navms.* TO navms@'localhost' IDENTIFIED BY 'navms';
-- GRANT ALL ON oozie.* TO oozie@'%' IDENTIFIED BY 'oozie';
-- update user set password=password('scm') WHERE user='scm';
-- update user set password=password('amon') WHERE user='amon';
-- update user set password=password('rman') WHERE user='rman';
-- update user set password=password('hue') WHERE user='hue';
-- update user set password=password('metastore') WHERE user='metastore';
-- update user set password=password('sentry') WHERE user='sentry';
-- update user set password=password('nav') WHERE user='nav';
-- update user set password=password('navms') WHERE user='navms';

update mysql.user set Grant_priv='Y',Super_priv='Y' where user = 'root' and host = '%';
flush privileges;