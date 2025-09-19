import axios from 'axios'

const api = axios.create({ baseURL: '/api' })

export const listPolls = () => api.get('/polls').then(r => r.data)
export const getPoll = (id) => api.get(`/polls/${id}`).then(r => r.data)
export const createPoll = (question, options) =>
  api.post('/polls', { question, options }).then(r => r.data)
export const vote = (pollId, optionId) =>
  api.post(`/polls/${pollId}/vote/${optionId}`).then(r => r.data)
