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
    Q_PROPERTY(double ha READ ha WRITE setHa)
    Q_PROPERTY(double k READ k WRITE setK)
    Q_PROPERTY(double n READ n WRITE setN)

public:
    explicit csvvazaohandler(QObject *parent = nullptr);
    void setFileUrl(const QUrl &arg);
    void setParsed(const bool value);
    void setHa(const double ha);
    void setK(const double k);
    void setN(const double n);
    QUrl fileUrl() const;
    bool parsed() const;
    double ha() const;
    double k() const;
    double n() const;
    Q_INVOKABLE
    void reset();
    Q_INVOKABLE
    void saveAs(const QUrl &arg, const QString &fileType);
    Q_INVOKABLE
    double calculo_vazao(const double ha);

signals:
    void fileUrlChanged();
    void parsedChanged(QString msg = QString::Null(), bool error = false);

private:
    QUrl m_fileUrl;
    QList<double> m_listVazao;
    bool m_parsed;
    double m_ha;
    double m_k;
    double m_n;
};

#endif // CSVVAZAOHANDLER_H
