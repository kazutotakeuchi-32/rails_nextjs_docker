import Image from 'next/image'
import Button from '@/components/elements/button'
import Layout from '@/components/layouts/user/index'
import useBearStore from '@/stores/bearState'

export default function PostsIndex() {
  const bears = useBearStore((state) => state.bears)

  const  increment = () => {
    useBearStore(state => state.increment())
  }

  

  return (
    <Layout>
        <div className="">  
          {
            bears
          }
          <button onClick={increment}>
            increment
          </button>
        </div>
    </Layout>
  )
}

