#ifndef CSVVAZAOHANDLER_H
#define CSVVAZAOHANDLER_H

#include <QObject>
#include <QUrl>
#include <qqmlfile.h>
#include <QFile>
#include <QTextCodec>
#include <QDebug>

class csvvazaohandler : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QUrl fileUrl READ fileUrl WRITE setFileUrl NOTIFY fileUrlChanged)
    Q_PROPERTY(bool parsed READ parsed WRITE setParsed NOTIFY parsedChanged)

public:
    explicit csvvazaohandler(QObject *parent = nullptr);
    void setFileUrl(const QUrl &arg);
    QUrl fileUrl() const;
    bool parsed() const;
    void setParsed(const bool value);
    Q_INVOKABLE
    void reset();
    Q_INVOKABLE
    void saveAs(const QUrl &arg, const QString &fileType);

signals:
    void fileUrlChanged();
    void parsedChanged(QString msg = QString::Null(), bool error = false);

private:
    QUrl m_fileUrl;
    QList<double> m_listVazao;
    bool m_parsed;
};

#endif // CSVVAZAOHANDLER_H
