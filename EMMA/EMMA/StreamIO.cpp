#include <QIODevice>
#include <QMutexLocker>
#include <QtConcurrent>
#include "StreamIO.h"

CurrentState StreamReader::next()
{
	return stream_io->read_at(pos, &pos);
}

bool StreamReader::atEnd()
{
	return stream_io->ends_at(pos);
}

void StreamReader::reset()
{
	pos = 0;
}

bool qfile_open(QFile* file, QIODevice::OpenMode mode)
{
	return file->open(mode);
}

StreamIO::StreamIO(const CurrentState* state, const QString& name):
	state(state),
	ioFile(name),
	ioStream(&ioFile),
	file_open_ret(QtConcurrent::run(qfile_open, &ioFile, QIODevice::ReadWrite))
{
}

StreamIO::~StreamIO()
{
}

bool StreamIO::flush()
{
	return ioFile.flush();
}

void StreamIO::write()
{
	file_open_ret.waitForFinished();
	{
		QMutexLocker lock(&ioFileMutex);
		ioStream << *state;
	}
	emit(dataSaveFinished());
}

StreamReader StreamIO::get_reader()
{
	StreamReader r(this);
	return r;
}

CurrentState StreamIO::read_at(qint64 pos, qint64* nextpos=nullptr)
{
	file_open_ret.waitForFinished();
	QMutexLocker lock(&ioFileMutex);
	auto write_pos = ioFile.pos();
	if(!ioFile.seek(pos))
	{
		throw io_error("StreamIO: cannot seek file to nextpos!");
	}
	else if(ioFile.atEnd())
	{
		throw io_error("StreamIO: file reached end!");
	}
	auto result = CurrentState::read_next_from_stream(ioStream);
	if(nextpos != nullptr)
	{
		*nextpos = ioFile.pos();
	}
	ioFile.seek(write_pos);
	return result;
}

bool StreamIO::ends_at(qint64 pos)
{
	auto write_pos = ioFile.pos();
	QMutexLocker lock(&ioFileMutex);
	bool seekable = ioFile.seek(pos);
	if(seekable)
	{
		seekable = !ioFile.atEnd();
	}
	ioFile.seek(write_pos);
	return !seekable;
}
