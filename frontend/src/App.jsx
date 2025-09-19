import { useEffect, useState } from 'react'
import { listPolls, getPoll, createPoll, vote } from './api'

function OptionRow({ option, onVote }) {
  return (
    <li className="option-row">
      <span>{option.text}</span>
      <span className="votes">{option.votes} votes</span>
      <button onClick={() => onVote(option.id)}>Vote</button>
    </li>
  )
}

export default function App() {
  const [polls, setPolls] = useState([])
  const [active, setActive] = useState(null)
  const [question, setQuestion] = useState('')
  const [newOptions, setNewOptions] = useState(['', ''])

  const refresh = async () => {
    try {
      const p = await listPolls()
      setPolls(p)
    } catch (e) {
      console.error('Failed to list polls', e)
    }
  }

  useEffect(() => { refresh() }, [])

  const open = async (id) => {
    try {
      const p = await getPoll(id)
      setActive(p)
    } catch (e) { console.error(e) }
  }

  const onCreate = async () => {
    const opts = newOptions.map(s => s.trim()).filter(Boolean)
    if (!question.trim() || opts.length < 2) return
    try {
      await createPoll(question, opts)
      setQuestion('')
      setNewOptions(['', ''])
      await refresh()
    } catch (e) { console.error(e) }
  }

  const onVote = async (optionId) => {
    if (!active) return
    try {
      const p = await vote(active.id, optionId)
      setActive(p)
      await refresh()
    } catch (e) { console.error(e) }
  }

  return (
    <div className="container">
      <h1>QuickPoll</h1>

      <section className="create">
        <h2>Create a Poll</h2>
        <input placeholder="Question" value={question} onChange={e => setQuestion(e.target.value)} />
        {newOptions.map((v, i) => (
          <input key={i} placeholder={`Option ${i + 1}`} value={v}
            onChange={e => {
              const copy = [...newOptions]; copy[i] = e.target.value; setNewOptions(copy)
            }} />
        ))}
        <div className="create-actions">
          <button onClick={() => setNewOptions(o => [...o, ''])}>+ add option</button>
          <button onClick={onCreate}>Create</button>
        </div>
      </section>

      <section className="lists">
        <div className="polls">
          <h2>Polls</h2>
          <ul>
            {polls.map(p => (
              <li key={p.id}>
                <button className="link" onClick={() => open(p.id)}>{p.question}</button>
              </li>
            ))}
          </ul>
        </div>

        <div className="details">
          <h2>Details</h2>
          {active ? (
            <div>
              <h3>{active.question}</h3>
              <ul>
                {active.options?.map(o => (
                  <OptionRow key={o.id} option={o} onVote={onVote} />
                ))}
              </ul>
            </div>
          ) : <p>Select a poll.</p>}
        </div>
      </section>
    </div>
  )
}
