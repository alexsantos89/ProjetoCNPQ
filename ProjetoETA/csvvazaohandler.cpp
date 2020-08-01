#include "csvvazaohandler.h"

csvvazaohandler::csvvazaohandler(QObject *parent) : QObject(parent)
{
    setParsed(false);
}

void csvvazaohandler::setFileUrl(const QUrl &arg)
{
    if (m_fileUrl != arg) {
        m_fileUrl = arg;
        emit fileUrlChanged();

        QString fileName = QQmlFile::urlToLocalFileOrQrc(arg);
        if (QFile::exists(fileName)) {
            QFile file(fileName);
            if (file.open(QFile::ReadOnly)) {
                m_listVazao.clear();
                while (!file.atEnd()) {
                    QByteArray data = file.readLine();
                    //wordList.append(line.split(',').first());
                    //QByteArray data = file.readAll();
                    QTextCodec *codec = QTextCodec::codecForHtml(data);
                    QString line = codec->toUnicode(data);
                    qDebug() << line;                                 
                    bool flag;
                    double v = line.split(",").first().toDouble(&flag);
                    if(!flag){
                        qDebug() << "Error during conversion to double";
                        m_fileUrl = nullptr;
                        emit fileUrlChanged();
                        setParsed(false);
                        emit parsedChanged(QString("Arquivo CSV inválido!"),true);
                        return;
                    }
                    m_listVazao.append(v);
                }
            }
        }

        setParsed(true);
        emit parsedChanged(QString("Arquivo CSV importado com sucesso!"));
    }
}

void csvvazaohandler::saveAs(const QUrl &arg, const QString &fileType)
{
    QLatin1String ext(".csv");
    QString localPath = arg.toLocalFile();
    if (!localPath.endsWith(ext))
        localPath += ext;
    QFile f(localPath);
    if (!f.open(QFile::WriteOnly | QFile::Truncate | QFile::Text)) {
        //TODO emitir error
        //emit error(tr("Cannot save: ") + f.errorString());
        return;
    }

    QTextStream streamOut(&f);

    for (int i = 0; i < m_listVazao.size(); ++i) {
        streamOut << i << "," << "10" << Qt::endl;
    }

    f.close();
}

QUrl csvvazaohandler::fileUrl() const
{
    return m_fileUrl;
}

bool csvvazaohandler::parsed() const
{
    return m_parsed;
}

void csvvazaohandler::setParsed(const bool value)
{
    m_parsed = value;
}

void csvvazaohandler::reset()
{
    m_fileUrl = nullptr;
    m_parsed = false;
    emit parsedChanged();
}
