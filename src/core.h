#ifndef CORE_H
#define CORE_H

#include <QObject>
#include <QString>
#include <apgcli.h>
#include <QDebug>
#include <QUrl>
#include <QDebug>
#include <e32std.h>
#include <apacmdln.h>

#include <e32math.h>
#include <APACMDLN.H>
#include <W32STD.H>
#include <aknglobalmsgquery.h>
#include <aknglobalnote.h>
#include <BAFINDF.H>
#include <BADESCA.H>
#include <SWInstApi.h>
#include <APGTASK.H>
#include <e32base.h>
#include <e32des8.h>
class core : public QObject
{
    Q_OBJECT
public:
    QObject *obj;

    explicit core(QObject *parent = 0);
    Q_INVOKABLE void sisInstallGUI(const QString &sisname);
    Q_INVOKABLE void doRunApp(const QString &uidStr);

    Q_INVOKABLE void installUpdate();
    Q_INVOKABLE void killApp(const QString &uidDa);
signals:

    Q_INVOKABLE void categorieChanged();

public slots:

};

#endif // CORE_H
